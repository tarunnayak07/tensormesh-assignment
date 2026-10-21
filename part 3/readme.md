the problem is very complicated so i changed its workking
red light only at reset(green =0 and yellow =0)
transition only after green ticks down to zero
count only goes up when density at the lane is non zero
count given the highest priority
at each green others are yellow
the transtion depends at density counter at green going to 0
    

    2 greens can never occur cause each state only 1 green and the machine wont leeave its predefined states
    no directions starv as counter keeps increasing if there this density
    max count can go till is 5 as in the case of 3 1 1 1 the the green light stays at it untill any of the counter hits 3
    if all 3 hit it at the same time then the max the th elast priority can hit it is 5
    