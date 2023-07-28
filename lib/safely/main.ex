# defmodule Safely do

#   def safely(f, args) do
#     try do
#       IO.inspect("EXEC FUN")
#       apply(f, args)
#     catch
#       e ->
#         IO.inspect("ERROR AQUI")
#         throw({:error, e})
#     end
#   end
# end

# defmodule Safely.Main do

#   def run(a, b) do
#     Safely.safely(&add/2, [a, b])
#     # IO.inspect("Data: #{data}")
#   end

#   def add(a, b) do
#     try do
#     a + b
#     catch
#       e -> {:error, e}
#     end
#   end
# end
