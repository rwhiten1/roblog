class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      #t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.string :encrypted_password, :null => false, :default => '', :limit => 128

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      #t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    change_table :users do |t|
      t.remove :encrypted_password
      t.remove :password_salt
      t.remove :authentication_token
      t.remove :reset_password_token
      t.remove :remember_token
      t.remove :remember_created_at
      t.remove :sign_in_count
      t.remove :current_sign_in_at
      t.remove :last_sign_in_at
      t.remove :current_sign_in_ip
      t.remove :last_sign_in_ip
      t.remove :failed_attempts
      t.remove :unlock_token
      t.remove :locked_at
    end
    
  end
end
