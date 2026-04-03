NVCC        := nvcc
TARGET      := vecadd
SRC         := vecadd.cu
ARCH_FLAGS  := -gencode arch=compute_89,code=sm_89 \
               -gencode arch=compute_90,code=sm_90
NVCCFLAGS   := $(ARCH_FLAGS) -O2 -I.

all: $(TARGET)

$(TARGET): $(SRC)
	$(NVCC) $(NVCCFLAGS) -o $@ $<

run: $(TARGET)
	./$(TARGET)

profile: $(TARGET)
	mkdir -p $(CURDIR)/tmp
	TMPDIR=$(CURDIR)/tmp ncu --set full --export profile_output --force-overwrite ./$(TARGET)

clean:
	rm -f $(TARGET) profile_output.ncu-rep

.PHONY: all run profile clean
