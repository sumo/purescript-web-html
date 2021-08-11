module Web.HTML.Constrain where

import Prelude
import Data.Array (fromFoldable)
import Data.List (List)
import Data.Maybe (Maybe)
import Literals.Undefined (Undefined)
import Untagged.Union (class InOneOf, OneOf, asOneOf, maybeToUor)

-- | Implementation of types to support https://developer.mozilla.org/en-US/docs/Web/API/MediaTrackConstraints
type ConstrainBase r t
  = { ideal :: Maybe t
    , exact :: Maybe t
    | r
    }

type ConstrainArray t
  = { ideal :: List t
    , exact :: List t
    }

type ConstrainRange t
  = ConstrainBase ( min :: Maybe t, max :: Maybe t ) t

type ConstrainSingle t
  = ConstrainBase () t

data Constrained a
  = Plain a
  | Constrained (ConstrainSingle a)

instance funcConstrained :: Functor Constrained where
  map f (Plain a) = Plain (f a)
  map f (Constrained cs) = Constrained ({ ideal: f <$> cs.ideal, exact: f <$> cs.exact })

data ConstrainedRange a
  = NoRange a
  | ConstrainedRange (ConstrainRange a)

derive instance funcConstrainedRange :: Functor ConstrainedRange

data ConstrainedArray a
  = Single a
  | PlainArray (List a)
  | ConstrainedArray (ConstrainArray a)

derive instance funcConstrainedArray :: Functor ConstrainedArray

type ConstrainBoolean
  = Constrained Boolean

type ConstrainULong
  = ConstrainedRange Int

type ConstrainDOMString
  = ConstrainedArray String

type ConstrainDouble
  = ConstrainedRange Number

-- Native Mappings start here ---
type ConstrainableBase_ l a
  = { exact :: OneOf Undefined a
    , ideal :: OneOf Undefined a
    | l
    }

type Constrainable_ a
  = ConstrainableBase_ () a

type Constrainable a
  = OneOf a (Constrainable_ a)

constrained ::
  forall a.
  InOneOf
    (Constrainable_ a)
    a
    (Constrainable_ a) =>
  Constrained a -> Constrainable a
constrained (Plain a) = asOneOf a

constrained (Constrained cs) = asOneOf { ideal: (maybeToUor cs.ideal), exact: (maybeToUor cs.exact) }

type ConstrainRange_ a
  = ConstrainableBase_ ( min :: OneOf Undefined a, max :: OneOf Undefined a ) a

type ConstrainableRange a
  = OneOf a (ConstrainRange_ a)

constrainedRange ::
  forall a.
  InOneOf
    (ConstrainRange_ a)
    a
    (ConstrainRange_ a) =>
  ConstrainedRange a -> ConstrainableRange a
constrainedRange (NoRange a) = asOneOf a

constrainedRange (ConstrainedRange crs) = asOneOf { ideal: (maybeToUor crs.ideal), exact: (maybeToUor crs.exact), min: (maybeToUor crs.min), max: (maybeToUor crs.max) }

type ConstrainArray_ a
  = { exact :: OneOf Undefined (Array a)
    , ideal :: OneOf Undefined (Array a)
    }

type ConstrainableArray a
  = OneOf (Array a) (ConstrainArray_ a)

constrainedArray ::
  forall a.
  InOneOf
    (ConstrainArray_ a)
    a
    (ConstrainArray_ a) =>
  ConstrainedArray a -> ConstrainableArray a
constrainedArray (Single a) = asOneOf (fromFoldable [ a ])

constrainedArray (PlainArray a) = asOneOf (fromFoldable a)

constrainedArray (ConstrainedArray crs) = asOneOf ({ ideal: asOneOf (fromFoldable crs.ideal), exact: asOneOf (fromFoldable crs.exact) } :: ConstrainArray_ a)
