module Web.HTML.Navigator where

import Effect (Effect)
import Web.HTML.MediaDevices (MediaDevices)

foreign import data Navigator :: Type

foreign import language :: Navigator -> Effect String

foreign import languages :: Navigator -> Effect (Array String)

foreign import onLine :: Navigator -> Effect Boolean

foreign import platform :: Navigator -> Effect String

foreign import userAgent :: Navigator -> Effect String

foreign import mediaDevices :: Navigator -> Effect MediaDevices
