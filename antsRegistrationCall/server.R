library(shiny)
library(ANTsR)
library(tools)

shinyServer(function(input, output) {

  output$exe <- renderPrint({

    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.

    floatFlag = as.numeric((input$prec == "float"))
    call = paste("antsRegistration -d", input$dim, "--float", floatFlag )
    call = paste(call, "--interpolation", input$interp )

    fixedFile <- input$fixed
    movingFile <- input$moving

    renamed = ""

    if (!is.null(fixedFile)) {
      if ( length(grep(".nii.gz", fixedFile$name)) > 0) {
        renamed = paste(sep='',fixedFile$datapath,".nii.gz")
        file.rename(from=fixedFile$datapath, to=renamed)
      }
      fixedFile$datapath=renamed
      #x = antsImageRead(renamed, dim=as.numeric(input$dim), pixeltype=input$prec )
    }

    if ( !is.null(movingFile)) {
      if ( length(grep(".nii.gz", movingFile$name)) > 0) {
        renamed = paste(sep='',movingFile$datapath,".nii.gz")
        file.rename(from=movingFile$datapath, to=renamed)
      }
      movingFile$datapath=renamed
      #y = antsImageRead(renamed, dim=as.numeric(input$dim), pixeltype=input$prec )
    }

    return( { call } )
  })
})
