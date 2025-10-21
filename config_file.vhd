library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Configuration mealy of sequencer
configuration fifo_elastic of fifo_elastic is
  for fifo_elastic
    for sequencer: entity work.sequencer use entity
       work.sequencer(archi_mealy);
      --work.sequencer(archi_moore);
    end for;
  end for;
end fifo_elastic_mealy;