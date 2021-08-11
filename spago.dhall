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
  [ "aff"
  , "aff-promise"
  , "arrays"
  , "effect"
  , "either"
  , "enums"
  , "foreign"
  , "functions"
  , "js-date"
  , "lists"
  , "literals"
  , "maybe"
  , "media-types"
  , "newtype"
  , "nullable"
  , "prelude"
  , "psci-support"
  , "record"
  , "strings"
  , "unsafe-coerce"
  , "untagged-union"
  , "web-dom"
  , "web-events"
  , "web-file"
  , "web-storage"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
