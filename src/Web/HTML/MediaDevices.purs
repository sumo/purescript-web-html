-- | This module operates on media devices using the browser media device API. 
-- | See https://developer.mozilla.org/en-US/docs/Web/API/MediaDevices

-- | A simple example to use this API:
-- | video <- ... create a video element or get an element from the DOM.

-- | md <- mediaDevices n
-- |     let vc = Right (mkDefaultVideoMediaTrackConstraints {facingMode = Just (PlainArray (MD.Environment : singleton MD.Left))})
-- |     let ac = Right ( mkDefaultAudioMediaTrackContraints {channelCount = Just (ConstrainedRange { ideal : Just 4, exact : Just 2, min : Just 2, max : Nothing}) })
-- | launchAff_ do
-- |   mstream <- MD.getUserMedia md ({video : Just vc, audio : (Just ac)})
-- |   liftEffect (MD.srcObject video mstream)

module Web.HTML.MediaDevices where

import Control.Promise (Promise, toAffE)
import Data.Function.Uncurried (Fn2, runFn2)
import Effect (Effect)
import Effect.Aff (Aff)
import Web.HTML.MediaTrackConstraints (MediaStreamConstraints, MediaStreamConstraints_, toNativeMediaStreamConstraints)

foreign import data MediaDevices :: Type

foreign import data MediaStream :: Type

foreign import getUserMedia_ :: Fn2 MediaDevices MediaStreamConstraints_ (Effect (Promise MediaStream))

getUserMedia :: MediaDevices -> MediaStreamConstraints -> Aff MediaStream
getUserMedia md msc = toAffE (runFn2 getUserMedia_ md (toNativeMediaStreamConstraints msc))

