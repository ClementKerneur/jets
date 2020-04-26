# Class that include Definition should implement:
#
#   template - method should use @definition to build a CloudFormation template section
#
class Jets::Stack
  module Definition
    extend ActiveSupport::Concern

    # Example of usage that leads here:
    #
    #   Parameter.new(self, *definition).register
    #
    # Which  is defined in parameter/dsl.rb
    #
    # Example subclass: ExampleStack < Jets::Stack
    def initialize(subclass, *definition)
      @subclass = stack_class_of(subclass.to_s.constantize).to_s # important to use to_s, dont want the object as keys in @definitions
      @definition = definition.flatten
    end

    def stack_class_of(cls)
      [nil, Jets::Stack].include?(cls.superclass) ? cls : stack_class_of(cls.superclass)
    end

    def register
      self.class.register(@subclass, *@definition)
    end

    def camelize(attributes)
      Jets::Camelizer.transform(attributes)
    end

    class_methods do
      def register(subclass, *definition)
        @definitions ||= {}
        @definitions[subclass.to_s] ||= []
        # Create instance of the CloudFormation section class and register it.  Examples:
        #   Stack::Parameter.new(definition)
        #   Stack::Resource.new(definition)
        #   Stack::Output.new(definition)
        @definitions[subclass.to_s] << new(subclass, definition)
      end

      def definitions(subclass)
        @definitions ||= {}
        @definitions[subclass.to_s]
      end

      def all_definitions
        @definitions
      end
    end
  end
end
