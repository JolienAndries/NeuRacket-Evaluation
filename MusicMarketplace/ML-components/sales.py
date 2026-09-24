def infer_sales(targetConversion, timesViewed, timesSold, oldPrice):
    conversion = timesSold / timesViewed
    pressure = targetConversion / (targetConversion + conversion)
    discount = min(1 - pressure, 0.75)  # max 75% discount
    return oldPrice * discount

def train_sales(targetConversion, timesViewed, timesSold, oldPrice, chosenPrice):
    chosenPrice - oldPrice