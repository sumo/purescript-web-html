module Web.HTML.HTMLCanvasElement where

import Data.Maybe (Maybe)
import Effect (Effect)
import Prelude (Unit)
import Unsafe.Coerce (unsafeCoerce)
import Web.DOM (ChildNode, Element, Node, NonDocumentTypeChildNode, ParentNode)
import Web.Event.EventTarget (EventTarget)
import Web.HTML.HTMLElement (HTMLElement)
import Web.Internal.FFI (unsafeReadProtoTagged)
import Web.HTML.HTMLCanvasElement.Context

foreign import data HTMLCanvasElement :: Type

fromHTMLElement :: HTMLElement -> Maybe HTMLCanvasElement
fromHTMLElement = unsafeReadProtoTagged "HTMLCanvasElement"

fromElement :: Element -> Maybe HTMLCanvasElement
fromElement = unsafeReadProtoTagged "HTMLCanvasElement"

fromNode :: Node -> Maybe HTMLCanvasElement
fromNode = unsafeReadProtoTagged "HTMLCanvasElement"

fromChildNode :: ChildNode -> Maybe HTMLCanvasElement
fromChildNode = unsafeReadProtoTagged "HTMLCanvasElement"

fromNonDocumentTypeChildNode :: NonDocumentTypeChildNode -> Maybe HTMLCanvasElement
fromNonDocumentTypeChildNode = unsafeReadProtoTagged "HTMLCanvasElement"

fromParentNode :: ParentNode -> Maybe HTMLCanvasElement
fromParentNode = unsafeReadProtoTagged "HTMLCanvasElement"

fromEventTarget :: EventTarget -> Maybe HTMLCanvasElement
fromEventTarget = unsafeReadProtoTagged "HTMLCanvasElement"

toHTMLElement :: HTMLCanvasElement -> HTMLElement
toHTMLElement = unsafeCoerce

toElement :: HTMLCanvasElement -> Element
toElement = unsafeCoerce

toNode :: HTMLCanvasElement -> Node
toNode = unsafeCoerce

toChildNode :: HTMLCanvasElement -> ChildNode
toChildNode = unsafeCoerce

toNonDocumentTypeChildNode :: HTMLCanvasElement -> NonDocumentTypeChildNode
toNonDocumentTypeChildNode = unsafeCoerce

toParentNode :: HTMLCanvasElement -> ParentNode
toParentNode = unsafeCoerce

toEventTarget :: HTMLCanvasElement -> EventTarget
toEventTarget = unsafeCoerce

renderingContext2D :: HTMLCanvasElement -> Effect CanvasRenderingContext2D
renderingContext2D elem = getContext "2d" elem

renderingContextWebGL :: HTMLCanvasElement -> Effect WebGLRenderingContext
renderingContextWebGL elem = getContext "webgl" elem

foreign import getContext :: forall a.  String -> HTMLCanvasElement -> Effect a

foreign import width :: HTMLCanvasElement -> Effect Int
foreign import setWidth :: Int -> HTMLCanvasElement -> Effect Unit

foreign import height :: HTMLCanvasElement -> Effect Int
foreign import setHeight :: Int -> HTMLCanvasElement -> Effect Unit

--   DOMString toDataURL(optional DOMString type, any... arguments);
--   void toBlob(FileCallback? _callback, optional DOMString type, any... arguments);
-- };
