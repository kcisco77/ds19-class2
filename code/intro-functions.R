far_to_kel <- function(temp) {
  if(!is.numeric(temp)) {
    Stop("temp must be numeric")
  }
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return(kelvin) 
}

far_to_kel(0)
far_to_kel(32)

# Write a function of kelvin to celcius
kelvin_to_cel <- function(temp) {
  cel <- (temp-273.15)
  return(cel)
} 

kelvin_to_cel(0)

# Write a function converting  Fahrenheit to Celsius
# by reusing the two functions you just wrote
far_to_cel <- function(temp) {
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  cel <- (kelvin - 273.15)
  return(cel)
}

far_to_cel(32)


# another way
far_to_cel_2 <- function(temp){
  kel <- far_to_kel(temp)
  cel <- kel_to_cel(kel)
  return(cel)
} 

far_to_cel(32)


far_to_kel <- function(temp) {
  stopifnot(is.numeric(temp)) 
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  return(kelvin) 
}


far_to_cel_2 <- function(temp){
  stopifnot(is.numeric(temp))
  kel <- far_to_kel(temp)
  cel <- kel_to_cel(kel)
  return(cel)
} 
