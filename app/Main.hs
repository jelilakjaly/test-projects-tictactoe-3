module Main where


import Board






-- clears the terminal on linux
clearScreen :: IO ()
clearScreen = putStr "\ESC[2J"


strToNumber :: String -> Maybe Int 
strToNumber n = case n of 
    "1" -> Just 1
    "2" -> Just 2
    "3" -> Just 3
    "4" -> Just 4
    "5" -> Just 5
    "6" -> Just 6
    "7" -> Just 7
    "8" -> Just 8
    "9" -> Just 9
    _   -> Nothing

updateBoard :: Board -> Player -> Int -> Board 
updateBoard board@(Board c1 c2 c3 c4 c5 c6 c7 c8 c9) player num = 
    case num of
        1 -> if c1 == E
                then Board (cellOfPlayer player) c2 c3 c4 c5 c6 c7 c8 c9
                else board
        2 -> if c2 == E
                then Board c1 (cellOfPlayer player) c3 c4 c5 c6 c7 c8 c9
                else board
        3 -> if c3 == E
                then Board c1 c2 (cellOfPlayer player) c4 c5 c6 c7 c8 c9
                else board
        4 -> if c4 == E
                then Board c1 c2 c3 (cellOfPlayer player) c5 c6 c7 c8 c9
                else board
        5 -> if c5 == E
                then Board c1 c2 c3 c4 (cellOfPlayer player) c6 c7 c8 c9
                else board
        6 -> if c6 == E
                then Board c1 c2 c3 c4 c5 (cellOfPlayer player) c7 c8 c9
                else board
        7 -> if c7 == E
                then Board c1 c2 c3 c4 c5 c6 (cellOfPlayer player) c8 c9
                else board
        8 -> if c8 == E
                then Board c1 c2 c3 c4 c5 c6 c7 (cellOfPlayer player) c9
                else board
        9 -> if c9 == E
                then Board c1 c2 c3 c4 c5 c6 c7 c8 (cellOfPlayer player)
                else board
        _ -> board



updateGame :: Board -> Player -> IO ()
updateGame board player = do 
    clearScreen
    putStrLn (show board)
    if playerOWon board 
        then do 
            putStrLn "Player O wins."
            return ()
        else if playerXWon board 
                 then do 
                     putStrLn "Player X wins."
                     return ()
                 else if boardIsFull board 
                          then do
                              putStrLn "Nobody wins!"
                              return ()
                           else do 
                              putStrLn (show player ++ ", mark your position (1-9)")
                              numStr <- getLine 
                              case strToNumber numStr of
                                  Nothing -> updateGame board player
                                  Just n -> updateGame (updateBoard board player n) (nextPlayer player)



main :: IO ()
main = do 
    let board = Board E E E E E E E E E
    let player = PlayerO
    updateGame board player
