def infer_sales(targetConversion, timesViewed, timesSold, oldPrice):
    conversion = timesSold / timesViewed if timesViewed != 0 else 0
    pressure = targetConversion / (targetConversion + conversion) if targetConversion != 0 or conversion != 0 else 0
    discount = min(1 - pressure, 0.95)  # min 5% discount
    discount = max(discount, 0.25) # max 75% discount
    return oldPrice * discount

def train_sales(targetConversion, timesViewed, timesSold, oldPrice, chosenPrice):
    chosenPrice - oldPrice