module Web.HTML.HTMLCanvasElement.Context where

import Prelude

import Effect (Effect)

foreign import data CanvasRenderingContext2D :: Type

foreign import data WebGLRenderingContext :: Type

-- | Transformations

foreign import scale :: Int -> Int -> CanvasRenderingContext2D -> Effect Unit

foreign import translate :: Int -> Int -> CanvasRenderingContext2D -> Effect Unit

-- | Drawing Images

-- foreign import drawImage :: CanvasRenderingContext2D -> a -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> Effect Unit

-- | Type a must be one of 
-- |    HTMLImageElement
-- |    SVGImageElement
-- |    HTMLVideoElement
-- |    HTMLCanvasElement
-- |    ImageBitmap
-- |    OffscreenCanvas
foreign import drawImage :: forall a. a -> Int -> Int -> CanvasRenderingContext2D -> Effect Unit

foreign import beginPath :: CanvasRenderingContext2D -> Effect Unit

foreign import strokeStyle :: CanvasRenderingContext2D -> String -> Effect Unit

foreign import moveTo :: Int -> Int ->  CanvasRenderingContext2D -> Effect Unit

foreign import lineTo :: Int -> Int ->  CanvasRenderingContext2D -> Effect Unit

foreign import stroke :: CanvasRenderingContext2D -> Effect Unit

foreign import lineWidth :: Int ->  CanvasRenderingContext2D -> Effect Unit
