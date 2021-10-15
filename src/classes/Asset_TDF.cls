public class Asset_TDF {

    public static Asset getAsset(id accountId,String assetName, String assetStatus){
        
        Asset asst = new Asset(
        	AccountId = accountId,
            Name = assetName,
            Status = assetStatus
        );
        return asst;
    }
}