#Function to read path
readData <- function(path.name, file.name, column.types, missing.types) {
  read.csv(  paste(path.name, file.name, sep="/") , 
            colClasses=column.types,
            na.strings=missing.types )
}
#getwd()

Titanic.path <- getwd()
Titanic.path <-paste(Titanic.path, "Shared", sep="/")
train.data.file <- "train.csv"
test.data.file <- "test.csv"
missing.types <- c("NA", "")
train.column.types <- c('character',# datetime
                        'integer',  # season 
                        'integer',  # holiday
                        'integer',  # workingday
                        'integer',  # weather
                        'numeric',  # temp
                        'numeric',  # atemp
                        'numeric',  # humidity
                        'numeric',  # windspeed
				'integer',  # casual  
				'integer',  # registered  
				'integer'   # count                    
)
test.column.types <- train.column.types[1:9]     # # no Survived column in test.csv

train.raw <- readData(Titanic.path, train.data.file, 
                      train.column.types, missing.types)


test.raw <- readData(Titanic.path, test.data.file, 
                     test.column.types, missing.types)


#str(df.infer)
#str(df.train)