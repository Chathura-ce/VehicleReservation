package model;

public class CarModel {
    private int modelId;
    private String modelName;
    private int typeId; // Foreign key referencing the car type

    public CarModel() {
    }

    public CarModel(int modelId, String modelName, int typeId) {
        this.modelId = modelId;
        this.modelName = modelName;
        this.typeId = typeId;
    }

    public int getModelId() {
        return modelId;
    }

    public void setModelId(int modelId) {
        this.modelId = modelId;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    @Override
    public String toString() {
        return "CarModel{" +
                "modelId=" + modelId +
                ", modelName='" + modelName + '\'' +
                ", typeId=" + typeId +
                '}';
    }
}
