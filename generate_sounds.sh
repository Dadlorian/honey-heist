#!/usr/bin/env bash
# generate_sounds.sh — Generate 8-bit retro sound effects for Honey Heist
# Uses Python to synthesize WAV files (Gemini's audio API is TTS-focused,
# not suited for retro sound effect generation, so we synthesize directly).
# Saves base64 WAV data to sounds/ directory for embedding in index.html.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOUNDS_DIR="$SCRIPT_DIR/sounds"
mkdir -p "$SOUNDS_DIR"

echo "=== Cyber-Thor's Honey Heist — Sound Generator ==="
echo "Generating 8-bit retro sound effects..."
echo ""

python3 << 'PYEOF'
import struct
import math
import base64
import os

SOUNDS_DIR = os.path.join(os.path.dirname(os.path.abspath(".")), "sounds")
# Use the script's sounds dir
SOUNDS_DIR = os.environ.get("SOUNDS_DIR", "sounds")

SAMPLE_RATE = 22050

def make_wav(samples, sample_rate=SAMPLE_RATE):
    """Create WAV file bytes from float samples (-1.0 to 1.0)."""
    # Convert to 8-bit unsigned PCM
    pcm = bytes(max(0, min(255, int((s * 0.5 + 0.5) * 255))) for s in samples)
    # WAV header
    data_size = len(pcm)
    header = struct.pack('<4sI4s', b'RIFF', 36 + data_size, b'WAVE')
    fmt = struct.pack('<4sIHHIIHH', b'fmt ', 16, 1, 1, sample_rate, sample_rate, 1, 8)
    data = struct.pack('<4sI', b'data', data_size) + pcm
    return header + fmt + data

def save_sound(name, wav_bytes):
    """Save WAV and base64 files."""
    wav_path = os.path.join(SOUNDS_DIR, f"{name}.wav")
    b64_path = os.path.join(SOUNDS_DIR, f"{name}.b64")
    with open(wav_path, 'wb') as f:
        f.write(wav_bytes)
    b64_data = base64.b64encode(wav_bytes).decode('ascii')
    with open(b64_path, 'w') as f:
        f.write(b64_data)
    print(f"  OK: {name}.wav ({len(wav_bytes)} bytes), {name}.b64 saved")

def square_wave(freq, t):
    """Square wave oscillator (8-bit feel)."""
    return 1.0 if (t * freq) % 1.0 < 0.5 else -1.0

def noise(t):
    """Pseudo-random noise."""
    import random
    random.seed(int(t * SAMPLE_RATE))
    return random.random() * 2 - 1

def generate_pollen_pickup():
    """Short coin/blip sound — rising pitch chirp."""
    duration = 0.12
    samples = []
    n = int(SAMPLE_RATE * duration)
    for i in range(n):
        t = i / SAMPLE_RATE
        progress = t / duration
        freq = 600 + progress * 800  # Rise from 600 to 1400 Hz
        vol = 1.0 - progress * 0.5   # Slight fade
        samples.append(square_wave(freq, t) * vol * 0.7)
    return make_wav(samples)

def generate_token_pickup():
    """Rising chime — ascending arpeggio."""
    duration = 0.3
    samples = []
    n = int(SAMPLE_RATE * duration)
    notes = [523, 659, 784, 1047]  # C5, E5, G5, C6
    note_dur = duration / len(notes)
    for i in range(n):
        t = i / SAMPLE_RATE
        note_idx = min(int(t / note_dur), len(notes) - 1)
        freq = notes[note_idx]
        local_t = (t - note_idx * note_dur) / note_dur
        vol = max(0, 1.0 - local_t * 0.3)  # Slight decay per note
        # Overall envelope
        env = max(0, 1.0 - (t / duration) * 0.4)
        samples.append(square_wave(freq, t) * vol * env * 0.6)
    return make_wav(samples)

def generate_enemy_hit():
    """Damage buzz — descending noise burst."""
    duration = 0.25
    samples = []
    n = int(SAMPLE_RATE * duration)
    for i in range(n):
        t = i / SAMPLE_RATE
        progress = t / duration
        freq = 200 - progress * 100  # Descend from 200 to 100 Hz
        vol = max(0, 1.0 - progress * 1.2)  # Quick fade
        # Mix square wave with noise
        s = square_wave(freq, t) * 0.5 + noise(t) * 0.5
        samples.append(s * vol * 0.8)
    return make_wav(samples)

def generate_lightning_zap():
    """Electric zap/thunder — white noise burst with descending tone."""
    duration = 0.4
    samples = []
    n = int(SAMPLE_RATE * duration)
    for i in range(n):
        t = i / SAMPLE_RATE
        progress = t / duration
        # Crackling noise burst
        noise_vol = max(0, 1.0 - progress * 2.0) if progress < 0.5 else 0
        # Low rumble
        rumble_freq = 80 + (1 - progress) * 60
        rumble_vol = max(0, 1.0 - progress * 0.8)
        # High zap
        zap_freq = 2000 - progress * 1500
        zap_vol = max(0, 1.0 - progress * 3.0) if progress < 0.33 else 0
        s = (noise(t) * noise_vol * 0.4 +
             square_wave(rumble_freq, t) * rumble_vol * 0.3 +
             square_wave(zap_freq, t) * zap_vol * 0.3)
        samples.append(s * 0.9)
    return make_wav(samples)

def generate_rage_activation():
    """Power-up whoosh — ascending sweep with harmonics."""
    duration = 0.5
    samples = []
    n = int(SAMPLE_RATE * duration)
    for i in range(n):
        t = i / SAMPLE_RATE
        progress = t / duration
        # Sweeping frequency rise
        freq = 150 + progress * progress * 1200  # Exponential rise
        vol = min(1.0, progress * 3) * max(0, 1.0 - (progress - 0.7) * 3.3)
        # Add harmonic richness
        s = (square_wave(freq, t) * 0.5 +
             square_wave(freq * 1.5, t) * 0.25 +
             square_wave(freq * 2, t) * 0.15 +
             noise(t) * 0.1)
        samples.append(s * vol * 0.7)
    return make_wav(samples)

def generate_game_over():
    """Sad descending tones — minor key descent."""
    duration = 0.8
    samples = []
    n = int(SAMPLE_RATE * duration)
    notes = [392, 349, 330, 262]  # G4, F4, E4, C4 (sad descent)
    note_dur = duration / len(notes)
    for i in range(n):
        t = i / SAMPLE_RATE
        note_idx = min(int(t / note_dur), len(notes) - 1)
        freq = notes[note_idx]
        local_t = (t - note_idx * note_dur) / note_dur
        vol = max(0, 1.0 - local_t * 0.4)  # Decay per note
        # Overall fade
        env = max(0, 1.0 - (t / duration) * 0.3)
        # Slightly detuned for sadness
        s = (square_wave(freq, t) * 0.5 +
             square_wave(freq * 1.002, t) * 0.3 +  # Slight detune
             square_wave(freq * 0.5, t) * 0.2)      # Sub octave
        samples.append(s * vol * env * 0.6)
    return make_wav(samples)

# Generate all sounds
print("Generating sound effects...")
save_sound("pollen_pickup", generate_pollen_pickup())
save_sound("token_pickup", generate_token_pickup())
save_sound("enemy_hit", generate_enemy_hit())
save_sound("lightning_zap", generate_lightning_zap())
save_sound("rage_activation", generate_rage_activation())
save_sound("game_over", generate_game_over())
print("\nAll sounds generated!")
PYEOF

echo ""
echo "=== Done! Check sounds/ directory ==="
ls -la "$SOUNDS_DIR"/*.wav 2>/dev/null || echo "No WAV files generated."
ls -la "$SOUNDS_DIR"/*.b64 2>/dev/null || echo "No B64 files generated."
