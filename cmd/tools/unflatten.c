/**
 * @file
 * @brief adjust directed graphs to improve layout aspect ratio
 */

/*************************************************************************
 * Copyright (c) 2011 AT&T Intellectual Property 
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors: Details at https://graphviz.org
 *************************************************************************/


/*
 * Written by Stephen North
 * Updated by Emden Gansner
 */

#include    <stdbool.h>
#include    <stdio.h>
#include    <stdlib.h>
#include    <string.h>
#include    <cgraph/cgraph.h>
#include    <cgraph/exit.h>
#include    <cgraph/unreachable.h>
#include    <ingraphs/ingraphs.h>

#include <getopt.h>
#include "openFile.h"

static bool Do_fans = false;
static int MaxMinlen = 0;
static int ChainLimit = 0;
static int ChainSize = 0;
static Agnode_t *ChainNode;
static FILE *outFile;
static char *cmd;

static int myindegree(Agnode_t *n)
{
	return agdegree(n->root, n, 1, 0);
}

/* need outdegree without selfarcs */
static int myoutdegree(Agnode_t *n)
{
	Agedge_t 	*e;
	int rv = 0;

	for (e = agfstout(n->root, n); e; e = agnxtout(n->root, e)) {
		if (agtail(e) != aghead(e)) rv++;
	}
	return rv;
}

static bool isleaf(Agnode_t * n)
{
    return myindegree(n) + myoutdegree(n) == 1;
}

static bool ischainnode(Agnode_t * n)
{
    return myindegree(n) == 1 && myoutdegree(n) == 1;
}

static void adjustlen(Agedge_t * e, Agsym_t * sym, int newlen)
{
    char buf[12];

    snprintf(buf, sizeof(buf), "%d", newlen);
    agxset(e, sym, buf);
}

static Agsym_t *bindedgeattr(Agraph_t * g, char *str)
{
    return agattr(g, AGEDGE, str, "");
}

static void transform(Agraph_t * g)
{
    Agnode_t *n;
    Agedge_t *e;
    char *str;
    Agsym_t *m_ix, *s_ix;
    int cnt, d;

    m_ix = bindedgeattr(g, "minlen");
    s_ix = bindedgeattr(g, "style");

    for (n = agfstnode(g); n; n = agnxtnode(g, n)) {
	d = myindegree(n) + myoutdegree(n);
	if (d == 0) {
	    if (ChainLimit < 1)
		continue;
	    if (ChainNode) {
		e = agedge(g, ChainNode, n, "", TRUE);
		agxset(e, s_ix, "invis");
		ChainSize++;
		if (ChainSize < ChainLimit)
		    ChainNode = n;
		else {
		    ChainNode = NULL;
		    ChainSize = 0;
		}
	    } else
		ChainNode = n;
	} else if (d > 1) {
	    if (MaxMinlen < 1)
		continue;
	    cnt = 0;
	    for (e = agfstin(g, n); e; e = agnxtin(g, e)) {
		if (isleaf(agtail(e))) {
		    str = agxget(e, m_ix);
		    if (str[0] == 0) {
			adjustlen(e, m_ix, cnt % MaxMinlen + 1);
			cnt++;
		    }
		}
	    }

	    cnt = 0;
	    for (e = agfstout(g, n); e; e = agnxtout(g, e)) {
		if (isleaf(e->node) || (Do_fans && ischainnode(e->node))) {
		    str = agxget(e, m_ix);
		    if (str[0] == 0)
			adjustlen(e, m_ix, cnt % MaxMinlen + 1);
		    cnt++;
		}
	    }
	}
    }
}


static char *useString =
    "Usage: %s [-f?] [-l l] [-c l] [-o outfile] <files>\n\
  -o <file> - put output in <file>\n\
  -f        - adjust immediate fanout chains\n\
  -l <len>  - stagger length of leaf edges between [1,l]\n\
  -c <len>  - put disconnected nodes in chains of length l\n\
  -?        - print usage\n";

static void usage(int v)
{
    fprintf(stderr, useString, cmd);
    graphviz_exit(v);
}

static char **scanargs(int argc, char **argv)
{
    int c, ival;

    cmd = argv[0];
    opterr = 0;
    while ((c = getopt(argc, argv, ":fl:c:o:")) != -1) {
	switch (c) {
	case 'f':
	    Do_fans = true;
	    break;
	case 'l':
	    ival = atoi(optarg);
	    if (ival > 0)
		MaxMinlen = ival;
	    break;
	case 'c':
	    ival = atoi(optarg);
	    if (ival > 0)
		ChainLimit = ival;
	    break;
	case 'o':
	    if (outFile != NULL)
		fclose(outFile);
	    outFile = openFile(cmd, optarg, "w");
	    break;
	case '?':
	    if (optopt == '?')
		usage(0);
	    else {
		fprintf(stderr, "%s: option -%c unrecognized\n", cmd,
			optopt);
		usage(-1);
	    }
	    break;
	case ':':
	    fprintf(stderr, "%s: missing argument for option -%c\n",
		    cmd, optopt);
	    usage(-1);
	    break;
	default:
	    UNREACHABLE();
	}
    }
    if (Do_fans && MaxMinlen < 1)
	fprintf(stderr, "%s: Warning: -f requires -l flag\n", cmd);
    argv += optind;
    argc -= optind;

    if (!outFile)
	outFile = stdout;
    if (argc)
	return argv;
    else
	return 0;
}

int main(int argc, char **argv)
{
    Agraph_t *g;
    ingraph_state ig;
    char **files;

    files = scanargs(argc, argv);
    newIngraph(&ig, files);
    while ((g = nextGraph(&ig))) {
	transform(g);
	agwrite(g, outFile);
    }
    graphviz_exit(0);
}
