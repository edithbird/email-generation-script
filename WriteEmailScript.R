install.packages(c('blastula', 'curl'))
library(gt)
library(blastula)
library(curl)
library(tidyverse)
library(ggplot2)
library(glue)
library(formattable)
library(knitr)
# Create the plot data
variety <- rep(LETTERS[1:7], each = 40)
treatment <- rep(c("high", "low"), each = 20)
note <- seq(1:280) + sample(1:150, 280, replace = TRUE)
data <- data.frame(variety, treatment, note)

# Create the plot
the_plot <-
  ggplot(data, aes(x = variety, y = note, fill = treatment)) + 
  geom_boxplot()+theme_bw()




imgur_image <-
  add_imgur_image(
    image = the_plot,
    client_id = "851117406f0b457"
  )

the_table <- data %>% filter(variety == "A")
kable(the_table)
image <- "C:/Users/christine.iyer/Box/FY21 Weekly Admissions Reports Summary to Inform Agency Campaigns/SampleTable.PNG"
imgur_image <-
  add_imgur_image(
    image = image,
    client_id = "851117406f0b457"
  )

body_text <-
  glue(
    "
Good Afternoon Jon,

I wanted to follow up on the application flow for matriculated  \\
students in Online Programs. I matched the raw data you sent me from ME St \\
with the SF data to get the application timeline.\\
There's such a huge gap so I wanted you to double check it. \\
If it looks like you think it should, I'll proceed with my report.\\



{imgur_image}


Thank you,

Christine Iyer\\
Marketing Data Analyst\\
University of Southern Maine
"
  ) %>% md()

compose_email(body = body_text) %>%
  smtp_send(
    
    to = "christine.iyer@maine.edu",

    from = "christine.iyer@maine.edu",
    subject = "App Flow for Online Students",
    credentials = creds_key(id = "gmail")
  )
