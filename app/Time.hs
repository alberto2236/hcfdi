module Time where

import Data.Time (getCurrentTime, UTCTime (utctDay), fromGregorian, addDays)
import Data.Time.Calendar (toGregorian, addGregorianMonthsClip)
import Data.Functor ((<&>))
import Data.List.Split (splitOn)
            

today :: IO ((String, String, String),(String, String, String))
today = do
    (ys,ms,ds) <- getCurrentTime <&> (toGregorian . utctDay)
    return ((show ys,if ms<10 then "0"++show ms else show ms,if ds<10 then "0"++show ds else show ds),(show ys,if ms<10 then "0"++show ms else show ms,if ds<10 then "0"++show ds else show ds))

yesterday :: IO ((String, String, String),(String, String, String))
yesterday = do
    (ys,ms,ds) <- getCurrentTime <&> (toGregorian . addDays (-1) . utctDay)
    return ((show ys,if ms<10 then "0"++show ms else show ms,if ds<10 then "0"++show ds else show ds),(show ys,if ms<10 then "0"++show ms else show ms,if ds<10 then "0"++show ds else show ds))


thisMonth :: IO ((String, String, String),(String, String, String))
thisMonth = do
    (ys,ms,_) <- getCurrentTime <&> (toGregorian . utctDay)
    (ye',me',_) <- getCurrentTime <&> (toGregorian . addGregorianMonthsClip 1 . utctDay)
    let (ye,me,de) = toGregorian $ addDays (-1) $ fromGregorian ye' me' 1
    return ((show ys,if ms<10 then "0"++show ms else show ms,"01"),(show ye,if me<10 then "0"++show me else show me,if de<10 then "0"++show de else show de))

lastN :: Integer -> IO ((String, String, String),(String, String, String))
lastN n = do
    (ye,me,de) <- getCurrentTime <&> (toGregorian . utctDay)
    (ys,ms,ds) <- getCurrentTime <&> (toGregorian . addDays ((-1)*n)  . utctDay)
    return ((show ys,if ms<10 then "0"++show ms else show ms,if ds<10 then "0"++show ds else show ds),(show ye,if me<10 then "0"++show me else show me,if de<10 then "0"++show de else show de))


thisYear :: IO ((String, String, String),(String, String, String))
thisYear = do
    (y,_,_) <- getCurrentTime <&> (toGregorian . utctDay)
    return ((show y,"01","01"),(show y,"12","31"))


getPeriod :: Integer -> Int -> String -> ((String, String, String),(String, String, String))
getPeriod year 0 _ = ((show year,"01","01"),(show year,"12","31"))
getPeriod year month "0" = do
    let (ye,me,de) = (toGregorian . addDays (-1) . addGregorianMonthsClip 1) $ fromGregorian year month 1
    ((show year,if month<10 then "0"++show month else show month,"01"),(show ye,if me<10 then "0"++show me else show me,if de<10 then "0"++show de else show de))
getPeriod year month day = do
    let dsd = splitOn "/" day
        de = head dsd
        dd = if length dsd > 1 then last dsd else head dsd
        (ys,ms,ds) = toGregorian $ addDays (read dd) $ fromGregorian year month (read de)
    ((show ys,if ms<10 then "0"++show ms else show ms,if ds<10 then "0"++show ds else show ds),(show year,if month<10 then "0"++show month else show month,if length de == 1 then "0"++de else de))



parsePeriod :: String -> IO (Maybe (String,String))
parsePeriod "año" = thisYear <&> (\((ys,ms,ds),(ye,me,de)) -> Just (ys++ms++ds++"T00:00:00",ye++me++de++"T23:59:59"))
parsePeriod "mes" = thisMonth <&> (\((ys,ms,ds),(ye,me,de)) -> Just (ys++ms++ds++"T00:00:00",ye++me++de++"T23:59:59"))
parsePeriod "hoy" = today <&> (\((ys,ms,ds),(ye,me,de)) -> Just (ys++ms++ds++"T00:00:00",ye++me++de++"T23:59:59"))
parsePeriod _ = return Nothing

