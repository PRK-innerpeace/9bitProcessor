# Mind the filename! This must match your top level module name.

# The `create_clock` command defines a clock for the system
#
# There are _a ton_ of additional options for clocks to
# capture skew, jitter, distribution, etc; these go beyond
# the scope of this class. Your designs will probably want
# to modify the period (to go faster!), but nothing else.
create_clock -period 20.00 -name main_clock Clk

# This will automatically configure setup and hold time throughout your
# design, as opposed to you setting uncertainties explicitly. Setting up
# uncertainty manually is beyond the scope of this class, however timing
# analysis does require that uncertainty be set, so we let the tool do it.
derive_clock_uncertainty
