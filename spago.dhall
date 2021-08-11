{-
name": "purescript-web-html",
  "homepage": "https://github.com/purescript-web/purescript-web-html",
  "license": "MIT",
  "repository": {
    "type": "git",
    "url": "https://github.com/purescript-web/purescript-web-html.git"
  }
-}
{ name = "web-html"
, dependencies =
  [ "effect"
  , "enums"
  , "foreign"
  , "functions"
  , "js-date"
  , "maybe"
  , "media-types"
  , "newtype"
  , "nullable"
  , "prelude"
  , "psci-support"
  , "unsafe-coerce"
  , "web-dom"
  , "web-events"
  , "web-file"
  , "web-storage"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
