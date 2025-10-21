library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

configuration config_fifo of fifo_elastic_tb is
    for tb
        for dut: entity work.fifo_elastic
            for archi_fifo_elastic
                for sequencer: sequencer use entity
                    work.sequencer(archi_mealy);
                    --sequencer(archi_moore);
                end for;
            end for;
        end for;
    end for;
end config_fifo;