-- singleton
SoundManager = class(Object)
SoundManager.sounds = {}
SoundManager.isFadeOut = {}
SoundManager.isFadeIn  = {}
SoundManager.callFadeOut = {}
SoundManager.callFadeIn  = {}

function SoundManager:addSound(filename)
    local sound = love.audio.newSource("sounds/"..filename, "stream")
    self.sounds[filename..tostring(sound)] = sound
    return self.sounds[filename..tostring(sound)]
end

function SoundManager:nameSound(filename, name)
    local sound = love.audio.newSource(filename, "stream")
    self.sounds[name] = sound
    return self.sounds[name]
end

function SoundManager:getSound(name)
    return self.sounds[name]
end

function SoundManager:fadeIn(name, callback)
    local sound = self.sounds[name]
    self.isFadeOut[name]  = false
    self.isFadeIn[name]   = true
    self.callFadeIn[name] = callback
end

function SoundManager:fadeOut(name, callback)
    local sound = self.sounds[name]
    self.isFadeOut[name]  = true
    self.isFadeIn[name]   = false
    self.callFadeOut[name] = callback
end

function SoundManager:collect()
    for k,v in pairs(self.sounds) do
        if not v:isPlaying() and not v:isLooping() then
            self.sounds[k] = nil
        end
        --
        if self.isFadeOut[k] then
            v:setVolume(math.max(v:getVolume() - 0.02, 0))
            if v:getVolume() <= 0 then
                local callback = self.callFadeOut[k]
                if callback then callback() end
            end
        end
        --
        if self.isFadeIn[k] then
            v:setVolume(math.min(v:getVolume() + 0.005, 1))
            if v:getVolume() >= 1 then
                local callback = self.callFadeIn[k]
                if callback then callback() end
            end
        end
    end
end
