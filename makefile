include $(PQ_FACTORY)/factory.mk

pq_part_name := jemalloc-3.6.0
pq_part_file := $(pq_part_name).tar.bz2

pq_jemalloc_configuration_flags += --prefix=$(part_dir)

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir)
	$(MAKE) -C $(pq_part_name) mkinstalldirs=$(part_dir) DESTDIR=$(stage_dir) install
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	cd $(pq_part_name) && ./configure $(pq_jemalloc_configuration_flags)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
