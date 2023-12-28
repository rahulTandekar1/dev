public virtual class SObjectTriage {
    
    protected final Map<Id, SObject> oldMap;
    protected final List<SObject> newList;
    
    protected SObjectTriage(Map<Id, SObject> oldMap, List<SObject> newList) {
        this.oldMap = oldMap;
        this.newList = newList;
    }
    
    public void handle(TriggerOperation operation) {
        switch on operation {
            when BEFORE_INSERT  { onBeforeInsert();  }
            when BEFORE_UPDATE  { onBeforeUpdate();  }
            when BEFORE_DELETE  { onBeforeDelete();  }
            when AFTER_INSERT   { onAfterInsert();   }
            when AFTER_UPDATE   { onAfterUpdate();   }
            when AFTER_DELETE   { onAfterDelete();   }
            when AFTER_UNDELETE { onAfterUndelete(); }
        }
    }
    
    // Define the onBeforeInsert method to handle BEFORE_INSERT logic
    protected virtual void onBeforeInsert() {
        // Implement your BEFORE_INSERT logic here
    }
    // Define the onBeforeUpdate method to handle BEFORE_INSERT logic
    protected virtual void onBeforeUpdate() {
        // Implement your BEFORE_Update logic here
    }
    // Define the onBeforeDelete method to handle BEFORE_INSERT logic
    protected virtual void onBeforeDelete() {
        // Implement your BEFORE_Delete logic here
    }
    // Define the onAfterInsert method to handle BEFORE_INSERT logic
    protected virtual void onAfterInsert() {
        // Implement your AFTER_INSERT logic here
    }
    
    // Define the onAfterUpdate method to handle BEFORE_INSERT logic
    protected virtual void onAfterUpdate() {
        // Implement your AFTER_Update logic here
    }
    // Define the onAfterDelete method to handle BEFORE_INSERT logic
    protected virtual void onAfterDelete() {
        // Implement your AFTER_Delete logic here
    }
    // Define the onAfterDelete method to handle BEFORE_INSERT logic
    protected virtual void onAfterUndelete() {
        // Implement your AFTER_Undelete logic here
    }
}