module type Symantics = sig
  include Lint_sym.Symantics
end

module Simple = Simple
module SimpleStaged = SimpleStaged
module ErrorHandling = ErrorHandling
module ErrorHandlingStaged = ErrorHandlingStaged
module CpsErrorHandling = CpsErrorHandling
module CpsErrorHandlingStaged = CpsErrorHandlingStaged
module InliningStaged = InliningStaged
module InliningNoDupStaged = InliningNoDupStaged
module InliningCPSErrorHandlingStaged = InliningCPSErrorHandlingStaged

