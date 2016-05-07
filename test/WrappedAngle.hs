{-# LANGUAGE DataKinds #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE QuasiQuotes #-}
{-# OPTIONS_GHC -fplugin Data.UnitsOfMeasure.Plugin #-}

module WrappedAngle
  ( WrappedAngle(..)
  ) where

import Data.UnitsOfMeasure.Defs ()
import Data.UnitsOfMeasure.Extra (u, Quantity, mod')
import Data.UnitsOfMeasure.QuickCheck ()
import Physics.Radian (turn)
import Test.Tasty.QuickCheck (Arbitrary)
import Test.QuickCheck.Checkers (EqProp(..), eq)

-- A wrapper which compares angles for equality modulo 2π
newtype WrappedAngle a = WrappedAngle (Quantity a [u|rad|])
  deriving (Show, Arbitrary)

instance (Floating a, Real a) => Eq (WrappedAngle a) where
  WrappedAngle x == WrappedAngle y = (x `mod'` turn) == (y `mod'` turn)

instance (Floating a, Real a) => EqProp (WrappedAngle a) where
  (=-=) = eq
