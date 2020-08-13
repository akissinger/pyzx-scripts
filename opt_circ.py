import sys
import os
sys.path.append('../pyzx')
import logging
import pyzx as zx
import random

fpath = sys.argv[1]
fname = os.path.basename(fpath)

log = logging.getLogger("log")
log.addHandler(logging.FileHandler("out/" + fname + ".log"))
log.setLevel(logging.INFO)
stats = logging.getLogger("stats")
stats.addHandler(logging.FileHandler("out/stats"))
stats.setLevel(logging.INFO)

log.info(fname)

#sys.exit(0)

random.seed(1337)

c = zx.Circuit.load(fpath)
log.info(c)

def post_process(c):
	c = c.split_phase_gates().to_basic_gates()
	return zx.optimize.basic_optimization(c).to_basic_gates()

def twoq_score(g):
	c = zx.extract_circuit(g.copy())
	c = post_process(c)
	return c.twoqubitcount()


gt = c.to_graph()
gt = zx.simplify.teleport_reduce(gt)
ct = zx.Circuit.from_graph(gt)
ct = post_process(ct)

g = c.to_graph()
zx.full_reduce(g)
g.normalize()

ce = zx.extract_circuit(g.copy())
ce = post_process(ce)

zx.sparsify.pivot_anneal(g, score=twoq_score, logger=log)
cs = zx.extract_circuit(g.copy())
cs = post_process(cs)

stats.info("%s%s%s%s" % (
  fname.ljust(30),
  str(ct.twoqubitcount()).rjust(7),
  str(ce.twoqubitcount()).rjust(7),
  str(cs.twoqubitcount()).rjust(7)))



