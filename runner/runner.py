from maya import standalone
import nimble
from nimble import execution
from nimble import NimbleEnvironment

standalone.initialize()

# Disable main thread execution idling in batch mode
execution.executionFunction = None

# Make the server available outside of the localhost scope
NimbleEnvironment.SERVER_HOST = '0.0.0.0'

nimble.startServer(inMaya=True, logLevel=2)
