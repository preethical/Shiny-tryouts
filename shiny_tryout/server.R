library(shiny)

shinyServer(function(input,output) {
    mtcars$mpgsp <- ifelse(mtcars$mpg - 20 > 0, mtcars$mpg - 20, 0)
    model1 <- lm(hp~mpg, data = mtcars)
    model2 <- lm(hp~ mpgsp+mpg, data = mtcars)
    
    model1pred <- reactive({
        mpgInput <- input$sliderMPG
        predict(model1, newdata=data.frame(mpg = mpgInput))
    })
    
    model2pred <- reactive({
        mpgInput <- input$sliderMPG
        predict(model1, newdata=data.frame(mpg = mpgInput,
                                          mpgsp = ifelse(mpgInput - 20 > 0,
                                                         mpgInput - 20, 0)))
    })
output$plot1 <- renderPlot({
    mpgInput <- input$sliderMPG
    plot(mtcars$mpg, mtcars$hp,xlab = "mpg", ylab ="hp", xlim = c(10,35), ylim = c(50,350))
    if(input$ShowModel1){
        abline(model1, col = "red", lwd = 2)
    }
    if (input$ShowModel2){
        model2lines <- predict(model2,newdata = data.frame(mpg = 10:35, mpgsp = ifelse(10:35 - 20>0, 10:35 - 20, 0)))
                            lines(10:35,model2lines,col = "blue",lwd = 2)
                            }
    legend(25,250,c("Model 1 prediction", "model 2 prediction"), pch = 16, col = c("red","blue"), bty = "n")
    points(mpgInput, model1pred(), col = "red")
    points(mpgInput, model2pred(), col = "blue")
    })    
    
        output$pred1 <- renderText({
            model1pred()
            })    
        output$pred2 <- renderText({
            model2pred()
        })    
        
})
