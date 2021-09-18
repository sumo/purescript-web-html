module Web.HTML.HTMLCanvasElement.ImageData where

import Data.ArrayBuffer.Types (Uint8ClampedArray)
import Effect (Effect)

foreign import data ImageData :: Type

foreign import data_ :: ImageData -> Effect Uint8ClampedArray

foreign import height :: ImageData -> Effect Int

foreign import width :: ImageData -> Effect Int
