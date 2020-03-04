CC = gcc
CFLAGS = -O1 -g -Wall -Werror -Idudect -I.

GIT_HOOKS := .git/hooks/applied
DUT_DIR := dudect
all: $(GIT_HOOKS) qtest

# Control the build verbosity
ifeq ("$(VERBOSE)","1")
    Q :=
    VECHO = @true
else
    Q := @
    VECHO = @printf
endif

# Enable sanitizer(s) or not
ifeq ("$(SANITIZER)","1")
    # https://github.com/google/sanitizers/wiki/AddressSanitizerFlags
    CFLAGS += -fsanitize=address -fno-omit-frame-pointer -fno-common
    LDFLAGS += -fsanitize=address
endif

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

OBJS := qtest.o report.o console.o harness.o queue.o strnatcmp.o \
        random.o dudect/constant.o dudect/fixture.o dudect/ttest.o
deps := $(OBJS:%.o=.%.o.d)

qtest: $(OBJS)
	$(VECHO) "  LD\t$@\n"
	$(Q)$(CC) $(LDFLAGS) -o $@ $^ -lm

%.o: %.c
	@mkdir -p .$(DUT_DIR)
	$(VECHO) "  CC\t$@\n"
	$(Q)$(CC) -o $@ $(CFLAGS) -c -MMD -MF .$@.d $<

check: qtest
	./$< -v 3 -f traces/trace-eg.cmd

test: qtest scripts/driver.py
	scripts/driver.py -c

valgrind_existence:
	@which valgrind 2>&1 > /dev/null || (echo "FATAL: valgrind not found"; exit 1)

valgrind: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind
	@echo
	@echo "Test with specific case by running command:" 
	@echo "scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t <tid>"


valgrind_01: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 01


valgrind_02: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 02


valgrind_03: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 03


valgrind_04: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 04


valgrind_05: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 05


valgrind_06: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 06


valgrind_07: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 07


valgrind_08: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 08


valgrind_09: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 09


valgrind_10: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 10


valgrind_11: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 11


valgrind_12: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 12


valgrind_13: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 13


valgrind_14: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 14


valgrind_15: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 15


valgrind_16: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 16


valgrind_17: valgrind_existence
	# Explicitly disable sanitizer(s)
	$(MAKE) clean SANITIZER=0 qtest
	$(eval patched_file := $(shell mktemp /tmp/qtest.XXXXXX))
	cp qtest $(patched_file)
	chmod u+x $(patched_file)
	sed -i "s/alarm/isnan/g" $(patched_file)
	scripts/driver.py -c -p $(patched_file) --valgrind -v 3 -t 17


clean:
	rm -f $(OBJS) $(deps) *~ qtest /tmp/qtest.*
	rm -rf .$(DUT_DIR)
	rm -rf *.dSYM
	(cd traces; rm -f *~)

-include $(deps)