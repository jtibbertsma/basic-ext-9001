module BasicExt9001
  class Guts
    def initialize(v = nil)
      @ivar = v
    end

    def var
      @ivar
    end

    def var=(v)
      @ivar = v
    end
  end
end