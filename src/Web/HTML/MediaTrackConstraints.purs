module Web.HTML.MediaTrackConstraints where


import Prelude

import Data.Either (Either(..)) as E
import Data.Either (Either)
import Data.Generic.Rep as Rep
import Data.List (fromFoldable)
import Data.Maybe (Maybe(..))
import Data.Show.Generic (genericShow)
import Data.String (toLower)
import Literals.Undefined (Undefined, undefined)
import Record as Rec
import Untagged.Union (class InOneOf, type (|+|), OneOf, asOneOf, maybeToUor, withUor)
import Web.HTML.Constrain (ConstrainBoolean, ConstrainDOMString, ConstrainDouble, ConstrainULong, Constrainable, ConstrainableArray, ConstrainableRange, ConstrainedArray(..), constrained, constrainedArray, constrainedRange)

type MediaTrackConstraints m = { deviceId :: Maybe ConstrainDOMString, groupId :: Maybe ConstrainDOMString | m }

type MediaTrackConstraintsBase_ m = { deviceId :: OneOf Undefined (ConstrainableArray String), groupId :: OneOf Undefined (ConstrainableArray String) | m }

toNativeMediaTrackConstraints mtc f = Rec.merge 
  { deviceId : withUor constrainedArray (maybeToUor mtc.deviceId)
  , groupId : withUor constrainedArray (maybeToUor mtc.groupId)
  } (f mtc)

data FacingMode = User | Environment | Left | Right 

derive instance repFacingMode :: Rep.Generic FacingMode _
derive instance eqFacingMode :: Eq FacingMode
instance showFacingMode :: Show FacingMode where
  show a = toLower (genericShow a)

data ResizeMode = None | CropAndScale
derive instance eqResizeMode :: Eq ResizeMode
instance showResizeMode :: Show ResizeMode where
  show None = "none"
  show CropAndScale = "crop-and-scale"

resizeModeToContrainedType :: ResizeMode -> ConstrainDOMString
resizeModeToContrainedType rm = PlainArray (fromFoldable [show rm])

type VideoMediaTrackConstraints = MediaTrackConstraints (
    aspectRatio :: Maybe ConstrainDouble,
    facingMode :: Maybe (ConstrainedArray FacingMode),
    frameRate :: Maybe ConstrainDouble,
    height :: Maybe ConstrainULong,
    width :: Maybe ConstrainULong, 
    resizeMode :: Maybe ResizeMode
    )

mkDefaultVideoMediaTrackConstraints :: VideoMediaTrackConstraints
mkDefaultVideoMediaTrackConstraints = {
    deviceId : Nothing,
    groupId : Nothing,
    aspectRatio : Nothing,
    facingMode : Nothing,
    frameRate : Nothing,
    height : Nothing,
    width : Nothing, 
    resizeMode : Nothing
}

type VideoMediaTrackConstraints_ = MediaTrackConstraintsBase_ (
    aspectRatio :: OneOf Undefined (ConstrainableRange Number),
    facingMode :: OneOf Undefined (ConstrainableArray String),
    frameRate :: OneOf Undefined (ConstrainableRange Number),
    height :: OneOf Undefined (ConstrainableRange Int),
    width :: OneOf Undefined (ConstrainableRange Int), 
    resizeMode :: OneOf Undefined (ConstrainableArray String)
    )

toNativeVideoMediaTrackConstraints :: VideoMediaTrackConstraints -> VideoMediaTrackConstraints_
toNativeVideoMediaTrackConstraints vmtc = toNativeMediaTrackConstraints vmtc  (\_->
  { aspectRatio : withUor constrainedRange (maybeToUor vmtc.aspectRatio),
    facingMode : withUor (\r -> constrainedArray (show <$> r)) (maybeToUor vmtc.facingMode),
    frameRate : withUor constrainedRange (maybeToUor vmtc.frameRate),
    height : withUor constrainedRange (maybeToUor vmtc.height),
    width : withUor constrainedRange (maybeToUor vmtc.width),
    resizeMode : withUor (\l -> constrainedArray (resizeModeToContrainedType l)) (maybeToUor vmtc.resizeMode)
  })


type AudioMediaTrackConstraints = MediaTrackConstraints ( 
    channelCount :: Maybe ConstrainULong,
    autoGainControl :: Maybe ConstrainBoolean, 
    echoCancellation :: Maybe ConstrainBoolean,
    latency :: Maybe ConstrainDouble,
    noiseSuppression :: Maybe ConstrainBoolean,
    sampleRate :: Maybe ConstrainULong,
    sampleSize :: Maybe ConstrainULong,
    volume :: Maybe ConstrainDouble
)

mkDefaultAudioMediaTrackContraints :: AudioMediaTrackConstraints
mkDefaultAudioMediaTrackContraints = {
    deviceId : Nothing,
    groupId : Nothing,
    channelCount : Nothing,
    autoGainControl : Nothing, 
    echoCancellation : Nothing,
    latency : Nothing,
    noiseSuppression : Nothing,
    sampleRate : Nothing,
    sampleSize : Nothing,
    volume : Nothing
    }

type AudioMediaTrackConstraints_ = MediaTrackConstraintsBase_ (
    autoGainControl :: OneOf Undefined (Constrainable Boolean), 
    channelCount :: OneOf Undefined (ConstrainableRange Int),
    echoCancellation :: OneOf Undefined (Constrainable Boolean),
    latency :: OneOf Undefined (ConstrainableRange Number),
    noiseSuppression :: OneOf Undefined (Constrainable Boolean),
    sampleRate :: OneOf Undefined (ConstrainableRange Int),
    sampleSize :: OneOf Undefined (ConstrainableRange Int),
    volume :: OneOf Undefined (ConstrainableRange Number)
)
  
toNativeAudioMediaTrackConstraints :: AudioMediaTrackConstraints -> AudioMediaTrackConstraints_
toNativeAudioMediaTrackConstraints amtc = toNativeMediaTrackConstraints amtc  (\_->
  { channelCount : withUor constrainedRange (maybeToUor amtc.channelCount),
    autoGainControl : withUor constrained (maybeToUor amtc.autoGainControl),
    echoCancellation : withUor constrained (maybeToUor amtc.echoCancellation),
    latency : withUor constrainedRange (maybeToUor amtc.latency),
    noiseSuppression : withUor constrained (maybeToUor amtc.noiseSuppression),
    sampleRate : withUor constrainedRange (maybeToUor amtc.sampleRate),
    sampleSize : withUor constrainedRange (maybeToUor amtc.sampleSize),
    volume : withUor constrainedRange (maybeToUor amtc.volume)
  })

type MediaTrackConstraints_ = Boolean |+| Undefined |+| VideoMediaTrackConstraints_ |+| AudioMediaTrackConstraints_


type MediaStreamConstraints =
  { video :: Maybe (E.Either Boolean VideoMediaTrackConstraints)
  , audio :: Maybe (E.Either Boolean AudioMediaTrackConstraints)
  }

type MediaStreamConstraints_ = 
  { audio :: MediaTrackConstraints_
  , video :: MediaTrackConstraints_
  }

toNativeMediaStreamConstraints :: MediaStreamConstraints -> MediaStreamConstraints_
toNativeMediaStreamConstraints msc =  
  { video : boolOrVal msc.video toNativeVideoMediaTrackConstraints
  , audio : boolOrVal msc.audio toNativeAudioMediaTrackConstraints
  }

boolOrVal :: forall t104 t105 t108 t109 t115. 
  InOneOf Undefined t104 t105 => 
  InOneOf t109 t104 t105 => 
  InOneOf t115 t104 t105 => 
  Maybe (Either t109 t108) -> 
  (t108 -> t115) -> 
  OneOf t104 t105
boolOrVal vm f = case vm of
  Nothing -> asOneOf undefined
  Just (E.Left b) -> asOneOf b
  Just (E.Right vmtc) -> asOneOf (f vmtc)