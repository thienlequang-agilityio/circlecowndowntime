# Circle Time Countdown component

### Setup

Just import CustomCircleView.swift.

Because it is an UIView so you can create a view and set class to CustomCircleView.

###  second view:
Choice typeRaw = 3 or set in code:  

        secondsView.typeRaw = 3
    
### Minute view:
Choice typeRaw = 2 or set in code:  

        minutesView.typeRaw = 2

### Hour view:
Choice typeRaw = 1 or set in code:  

        hoursView.typeRaw = 1
        
### Day view:
Choice typeRaw = 0 or set in code:  

        days.typeRaw = 0

And you should set countdownTime for view

        countdownTime = (24 * 3600) + 60 + 12

###  second view:
        secondsView.countdownSeconnd = countdownTime
        
###  minute view:
        minutesView.countdownMinute = Float(countdownTime) / 60.0
   
###  hours view:
        hoursView.countdownHour = Float(countdownTime) / 3600.0
        
###  days view:
        daysView.countdownDay = Float(countdownTime) / (24 * 3600.0)
with days wiew, we need set dayBetweenStartTimeAndEndTime
        
        daysView.dayBetweenStartTimeAndEndTime = 6
        
The code include example how to use this compnnent.

Thanks.

    