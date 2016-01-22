library(shiny)
library(ANTsR)

shinyUI(fluidPage(
  titlePanel("Assemble a call to antsRegistration"),
  sidebarLayout(
    sidebarPanel(
      h4("Image properties"),
      fluidRow(
        column(6,
          radioButtons("dim", label="Dimension", choices=list(2,3,4),
            inline=TRUE, selected=2) ),
        column(6,
          radioButtons("prec", label="Precision", choices=list(float="float", double="double"),
          inline=TRUE, selected="float") )
        ),

      h4("Image files"),
      fluidRow(
        column(6, fileInput('fixed', 'Choose Fixed Image')) ,
        column(6, fileInput('moving', 'Choose Moving Image'))
        ),

      h4("Global options"),

      selectInput("interp", label="Interpolation", choices=list("Linear",
                         "NearestNeighbor",
                         "MultiLabel",
                         "Gaussian",
                         "BSpline",
                         "CosineWindowedSinc",
                         "WelchWindowedSinc",
                         "HammingWindowedSinc",
                         "LanczosWindowedSinc"), selected="Linear" ),
      h4("Registration Stage 1"),
      selectInput("tx1", label="Transform", choices=list("Rigid", "Affine", "SyN"), selected="Rigid"),
      numericInput( "stage1", label="Levels", value=1)

      #h4("Registration Stage"),
      #numericInput("num", label = "Number of levels", value = 1),

    ),
    mainPanel(
      verbatimTextOutput('exe')
    )
  )
))
