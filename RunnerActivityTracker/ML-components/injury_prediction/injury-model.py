# https://www.kaggle.com/code/soheiltehranipour/xgboost-tutorial-classification
# https://www.kaggle.com/code/saswattulo/neuralnet-xgbclassifier-logisticreg
import xgboost as xgb
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from joblib import dump, load

model_name_saved = '../ML-components/injury_prediction/injury_prediction_model.json'
input_scaler_name_saved = '../ML-components/injury_prediction/injury_input_scaler.joblib'

def bulk_train_classifier(dataset_path):
    # data 
    df = pd.read_csv(dataset_path)
    print(df.head())
    X=df.drop(['Likelihood_of_Injury'],axis=1) # axis=1 == drop een kolom ; axis=0 == drop een rij
    y=df['Likelihood_of_Injury']

    X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.25,random_state=42) # random seed for reproducibility
    
    # scale 
    input_scaler = StandardScaler() # de scaler voor mijn  input
    X_train_scaled=input_scaler.fit_transform(X_train) # fit op data dan transform 
    X_test_scaled=input_scaler.transform(X_test)

    # train
    classifier = xgb.XGBClassifier()
    classifier.fit(X_train_scaled, y_train)
    y_pred = classifier.predict(X_test_scaled)

    accuracy = accuracy_score(y_test, y_pred)
    print("Accuracy:", accuracy)

    # save 
    classifier.save_model(model_name_saved) # in de file waar ik het in run volgens mij
    dump(input_scaler, input_scaler_name_saved, compress=True)

#bulk_train_classifier('./injury_prediction_data.csv')

# try catch error dingen 
def predict_injury(age, weight, height, previous_injuries, training_intensity): 
    # load 
    input_scaler = load(input_scaler_name_saved)
    classifier = xgb.XGBClassifier()
    classifier.load_model(model_name_saved) 
    # scale
    input_df = pd.DataFrame([{
    "Player_Age": age,
    "Player_Weight": weight,
    "Player_Height": height,
    "Previous_Injuries": 1 if previous_injuries else 0,
    "Training_Intensity": training_intensity
    }])
    scaled_input = input_scaler.transform(input_df)
    # predict
    result = classifier.predict(scaled_input)
    return tuple([True if result[0] == 1 else False])

def train_injury_prediction(injury_risk,age, weight, height, previous_injuries, training_intensity):
    file_out = open("../../../new_injury_data.csv", "a")
    line = ','.join([str(age), str(weight), str(height), str(previous_injuries), str(training_intensity), str(injury_risk)]) + '\n'
    file_out.write(line)
    file_out.close()

# print(predict_injury(23, 56, 175, True, 0.4))