class Client < ApplicationRecord
    validates_presence_of :nom, :prenom, :email, :nomrue, :numrue, :codepostal, :ville, :tel
end
