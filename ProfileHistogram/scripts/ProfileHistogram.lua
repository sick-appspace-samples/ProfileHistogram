--Start of Global Scope---------------------------------------------------------

print('AppEngine Version: ' .. Engine.getVersion())

local DELAY = 500

-- Creating viewer
local v = View.create()

-- Create a GraphDecoration object for setting visual properties of the graph plot
local histogramDeco = View.GraphDecoration.create()
histogramDeco:setGraphType('BAR')
histogramDeco:setDrawSize(5)

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  --Plot histogram of a Gaussian noise distribution ---------------------------------------------
  for std = 0.1, 1.0, 0.1 do
    local noiseProfile = Profile.create(756, 3.0)
    Profile.addNoiseInplace(noiseProfile, 'NORMAL', std, 0.0, -1)

    local hist = Profile.getHistogram(noiseProfile, 21, -2.0, 8.0)

    histogramDeco:setTitle('Gaussian noise std: ' .. std)

    -- Plot the histogram
    v:clear()
    v:addProfile(hist, histogramDeco)
    v:present()

    Script.sleep(DELAY)
  end

  --Plot histogram of array with profiles ---------------------------------------------

  Script.sleep(DELAY)
  local profiles = {}
  for j = 0, 10 do
    profiles[#profiles + 1] = Profile.create(156, 3.0)
    Profile.addNoiseInplace(profiles[#profiles], 'NORMAL', 1.0, 0.0, -1)

    local hist = Profile.getHistogram(profiles, 21, -2.0, 8.0)

    histogramDeco:setTitle('#accumulated profiles: ' .. j + 1)
    v:clear()
    v:addProfile(hist, histogramDeco)
    v:present()

    Script.sleep(DELAY)
  end
  print('App finished.')
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope--------------------------------------------------
