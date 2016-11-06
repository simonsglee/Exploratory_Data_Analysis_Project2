# Script for donwloading and extracting data
if(!file.exists("./EDA_assignment_data.zip")) {
        file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
        download.file(file_url, destfile = "./EDA_assignment_data.zip")
}

if(!file.exists("./EDA_assignment_data")){
        unzip("./EDA_assignment_data.zip", exdir = "C:/Users/Simon/Documents/Rdirectory")
}
