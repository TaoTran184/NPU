TEST ?=smoke_test
INSTANCE ?=4
export INSTANCE

THIS :=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

BUILD_DIR ?= `pwd`/LOGS/$(TEST)
$(BUILD_DIR)/CFG.cfg:
        @echo "CREATE TEST DIR"
        @if [!-d $(BUILD_DIR)]; them mkdir -p $(BUILD_DIR); fi

.DEFAULT_GOAL := comp

.phony: help clean comp

help :
        @echo "XXXXX"

comp: ${BUILD_DIR}/CFG.cfg $(TEST)
       @echo "Common ..."

smoke_test:
    @cd $(BUILD_DIR) && vavlog -worklib -sv -define INSTACE=$(INSTANCE) $(THIS)/smoke_test.sv
 
clean:
    @cd $(BUILD_DIR)/../ & rm -f $(TEST)
    
    
