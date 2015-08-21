#!/usr/bin/env python
# a small script to transmit simulated GPS samples via UHD
# (C) 2015 by Harald Welte <laforge@gnumonks.org>
# Licensed under the MIT License (see LICENSE)

from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import gr
from gnuradio import uhd
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from optparse import OptionParser
import time

class top_block(gr.top_block):

    def __init__(self, options):
        gr.top_block.__init__(self, "GPS-SDR-SIM")

        ##################################################
        # Blocks
        ##################################################
        self.uhd_usrp_sink = uhd.usrp_sink(
        	",".join(("", "")),
        	uhd.stream_args(
        		cpu_format="fc32",
        		channels=range(1),
        	),
        )
        self.uhd_usrp_sink.set_samp_rate(options.sample_rate)
        self.uhd_usrp_sink.set_center_freq(options.frequency, 0)
        self.uhd_usrp_sink.set_gain(options.gain, 0)

        # a file source for the file generated by the gps-sdr-sim
        self.blocks_file_source = blocks.file_source(gr.sizeof_char*1, options.filename, True)

        # convert from signed bytes to short
        self.blocks_char_to_short = blocks.char_to_short(1)

        # convert from interleaved short to complex values
        self.blocks_interleaved_short_to_complex = blocks.interleaved_short_to_complex(False, False)

        # establish the connections
        self.connect((self.blocks_file_source, 0), (self.blocks_char_to_short, 0))
        self.connect((self.blocks_char_to_short, 0), (self.blocks_interleaved_short_to_complex, 0))
        self.connect((self.blocks_interleaved_short_to_complex, 0), (self.uhd_usrp_sink, 0))

def get_options():
    parser = OptionParser(option_class=eng_option)
    parser.add_option("-x", "--gain", type="eng_float", default=0,
                      help="set transmitter gain [default=0]")
    parser.add_option("-f", "--frequency", type="eng_float", default=1575420000,
                      help="set transmit frequency [default=1575420000]")
    # On USRP2, the sample rate should lead to an even decimator
    # based on the 100 MHz clock.  At 2.5 MHz, we end up with 40
    parser.add_option("-s", "--sample-rate", type="eng_float", default=2500000,
                      help="set sample rate [default=2500000]")
    parser.add_option("-t", "--filename", type="string", default="gpssim.bin",
                      help="set output file name [default=gpssim.bin]")

    (options, args) = parser.parse_args()
    if len(args) != 0:
        parser.print_help()
        raise SystemExit, 1

    return (options)

if __name__ == '__main__':
    (options) = get_options()
    tb = top_block(options)
    tb.start()
    raw_input('Press Enter to quit: ')
    tb.stop()
    tb.wait()