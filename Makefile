circuits = \
  bench/adder_8_before \
  bench/Adder8_before \
  bench/barenco_tof_10_before \
  bench/barenco_tof_3_before \
  bench/barenco_tof_4_before \
  bench/barenco_tof_5_before \
  bench/csla_mux_3_original_before \
  bench/csum_mux_9_corrected_before \
  bench/gf2^10_mult_before \
  bench/gf2^4_mult_before \
  bench/gf2^5_mult_before \
  bench/gf2^6_mult_before \
  bench/gf2^7_mult_before \
  bench/gf2^8_mult_before \
  bench/gf2^9_mult_before \
  bench/grover_5.qc \
  bench/ham15-low.qc \
  bench/hwb6.qc \
  bench/mod5_4_before \
  bench/mod_mult_55_before \
  bench/mod_red_21_before \
  bench/nth_prime6.tfc \
  bench/qcla_adder_10_before \
  bench/qcla_com_7_before \
  bench/qcla_mod_7_before \
  bench/QFT16_before \
  bench/qft_4.qc \
  bench/QFT8_before \
  bench/QFTAdd8_before \
  bench/rc_adder_6_before \
  bench/tof_10_before \
  bench/tof_3_before \
  bench/tof_4_before \
  bench/tof_5_before \
  bench/vbe_adder_3_before

logs = $(patsubst bench/%,out/%.log,$(circuits))

run: out/stats $(logs)

out/stats:
	mkdir -p out
	@echo "Circuit                            TR     FR     SR" > out/stats

$(logs) : out/%.log: bench/%
	python3 opt_circ.py $^

clean:
	rm out/*

pbs:
	mkdir -p pbs_out
	qsub opt_job.pbs


