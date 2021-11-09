clear
face = load('data.mat').face;
[face_train,face_test] = train_test_split(face,0.8);