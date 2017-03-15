module Lib where

import Control.Applicative
import Data.Char
import Data.Maybe
import Data.Functor

newtype Parser a = Parser { parse :: String -> Maybe (a,String) }

data Proposition = And Proposition Proposition | Or Proposition Proposition | Implies Proposition Proposition
                        | Not Proposition | Bottom | Truth | Constant String | Variable String

data Predicate = Forall' String Predicate | Exists' String Predicate | And' Predicate Predicate | Or' Predicate Predicate
                        | Implies' Predicate Predicate | Not' Predicate | Bottom' | Truth' | Constant' String 
                        | Variable' String deriving Show


showProposition, showTerm, showFactor, showLiteral, showAtom :: Proposition -> String
showProposition (Implies a b) = showTerm a ++ " → " ++ showProposition b
showProposition a = showTerm a

showTerm (Or a b) = showTerm a ++ " ∨ " ++ showFactor b
showTerm a = showFactor a

showFactor (And a b) = showFactor a ++ " ∧ " ++ showLiteral b
showFactor a = showLiteral a

showLiteral (Not a) = "¬" ++ showLiteral a
showLiteral a = showAtom a

showAtom (Constant a) = a
showAtom (Variable a) = a
showAtom Bottom = "⊥"
showAtom Truth = "⊤"
showAtom a = "(" ++ showProposition a ++ ")"

instance Show Proposition where
    show = showProposition

instance Functor Parser where
  fmap f p = Parser $ \s -> (\(a,c) -> (f a, c)) <$> parse p s

instance Applicative Parser where
  pure a = Parser $ \s -> Just (a,s)
  f <*> a = Parser $ \s ->
    case parse f s of
      Just (g,s') -> parse (fmap g a) s'
      Nothing -> Nothing

instance Alternative Parser where
  empty = Parser $ \s -> Nothing
  l <|> r = Parser $ \s -> parse l s <|> parse r s

instance Monad Parser where
    return = pure
    pa >>= f = Parser $ \s ->
                case parse pa s of
                    Just (a, s') -> parse (f a) s'
                    Nothing -> Nothing 

--A small collection of useful parser combinators.
ensure :: (a -> Bool) -> Parser a -> Parser a
ensure p parser = Parser $ \s ->
   case parse parser s of
     Nothing -> Nothing
     Just (a,s') -> if p a then Just (a,s') else Nothing

lookahead :: Parser (Maybe Char)
lookahead = Parser f
  where f [] = Just (Nothing,[])
        f (c:s) = Just (Just c,c:s)

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = Parser f
  where f [] = Nothing
        f (x:xs) = if p x then Just (x,xs) else Nothing

eof :: Parser ()
eof = void $ ensure isNothing lookahead

ws :: Parser ()
ws = void $ many (satisfy isSpace)

char :: Char -> Parser Char
char c = satisfy (==c)

chainl1 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainl1 p sep = foldl (\acc (op,v) -> op acc v) <$> p <*> many ((\op v -> (op,v)) <$> sep <*> p)

chainr1 :: Parser a -> Parser (a -> a -> a) -> Parser a
chainr1 p sep =  do a <- p
                    op <- sep
                    rest <- chainr1 p sep
                    return $ op a rest
                <|> p

tryParse :: Parser a -> String -> Maybe a
tryParse parser text = fst <$> parse (parser <* ws <* eof) text

-- Constants must begin with an uppercase letter. They can contain any alphanumeric letters.
constantString :: Parser String
constantString = (:) <$> (satisfy isUpper) <*> many (satisfy isAlphaNum)

constantP :: Parser Proposition
constantP = Constant <$> constantString

-- Variables must begin with a lowercase letter. They can contain any alphanumeric letters.
variableString :: Parser String
variableString = (:) <$> (satisfy isLower) <*> many (satisfy isAlphaNum)

variableP :: Parser Proposition
variableP = Variable <$> variableString 

parens :: Parser a -> Parser a
parens p = (char '(' *> p) <* char ')'

impliesP, orP, andP :: Parser (Proposition -> Proposition -> Proposition)
impliesP = char '→' *> pure Implies
orP = char '∨' *> pure Or
andP = char '∧' *> pure And

notP :: Parser (Proposition -> Proposition)
notP = char '¬' *> pure Not

bottomP, truthP :: Parser Proposition
bottomP = char '⊥' *> pure Bottom
truthP = char '⊤' *> pure Truth

propositionParser, factor, term, literal, atom :: Parser Proposition
propositionParser = factor `chainr1` (ws *> impliesP)
factor = term `chainl1` (ws *> orP)
term = literal `chainl1` (ws *> andP)
literal = ws *> notP <*> atom <|> atom
atom =  ws *> constantP <|> ws *> variableP <|> 
        ws *> bottomP <|> ws *> truthP <|> 
        ws *> parens propositionParser


impliesP', orP', andP' :: Parser (Predicate -> Predicate -> Predicate)
impliesP = char '→' *> pure Implies'
orP = char '∨' *> pure Or'
andP = char '∧' *> pure And'

notP' :: Parser (Predicate -> Predicate)
notP' = char '¬' *> pure Not'

bottomP, truthP :: Parser Predicate
bottomP = char '⊥' *> pure Bottom'
truthP = char '⊤' *> pure Truth'

predicateParser, factor', term', literal', atom' :: Parser Predicate