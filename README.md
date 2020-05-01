## Unstable Sound - sonification of modulation instability

*Unstable Sound* is a music piece composed using open-source software [Sonic Pi](https://sonic-pi.net/). The piece is inspired by a physical phenomenon called *modulation instability* and consists in the sonification of modulation instability of a light wave propagating in an optical fibre. 

## The sound of modulation instability

Listen to *Unstable Sound*, on soundcloud [here](https://soundcloud.com/matilde-aliffi/unstable-sound).

## What is modulation instability?

Modulation instability is a ubiquitous phenomenon occurring in a variety of different physical systems. It consists in the destruction of a wave propagating through a nonlinear medium. During its propagation, the input wave having a certain oscillation frequency loses energy at expenses of two other waves (perturbations) whose frequencies are symmetrically located with respect to the input one. The original input wave is hence destabilized and becomes modulated. Modulation instability occurs for water waves in oceans, light waves propagating in optical fibres, plasma waves and others. If you want to read a very basic introduction about modulation instability with special emphasis on optical fibres, Auro wrote a post [here](https://www.nonlinearlight.com/outreach-with-semi-di-scienza-instabilities-of-light/). Readers familiar with nonlinear physics could read classic scientific references such as [this one](https://people.math.umass.edu/~kevrekid/math697wa/sdarticle_ZO.pdf) by Zakharov and Ostrovsky.

## Why representing modulation instability with sound?

Representation of physical phenomena is usually provided either by mathematical formulas or graphical illustrations. The latter method consists of creating a correspondence between numerical data arising from experimental observation (or numerical experiments) and a particular graphical or colour code resulting in a picture illustration. In this project, we want to explore the artistic representation of scientific data produced in a numerical experiment in an alternative way: using sound. We consider this as the first attempt of an approach which we found fascinating.

## What did we do?

### Simulations

Simulated the propagation of continuous (fixed input amplitude) lightwave through a single-mode fibre using the established focusing nonlinear Schroedinger equation (NLSE) model under the conditions necessary to trigger modulation instability. Data were saved at regular spatial steps along with the fibre propagation. At each step amplitudes of the whole optical spectrum were saved. The data were saved in a .csv file.

### Data mapping (frequencies)

Data from numerical simulations of the NLSE have been mapped into values corresponding to amplitudes and frequencies to be played by sonic-pi. We mapped the optical frequency axes into acoustic ones by assigning the central optical frequency to 75 (MIDI note) and considering the maximum and the minimum optical frequencies corresponding to 35 and 115 (MIDI note). There is a clear arbitrariness in such choice, and different mapping choices will result in a different sonic translation of the original data. Our choice was motivated by the necessity of fitting the whole optical spectrum into a range fully audible by the human hearing. This, in a sense, is analogous to the choice that scientists operate when they select a particular colour code for the graphical representation of certain data.

### Data mapping (amplitudes)

Sonic-pi does not render the subtle differences in amplitudes that the data generates. We scaled amplitudes using a Gausssian function to adapt to the dynamic range of sonic-pi.
We filtered out the amplitudes below a certain threshold to improve the performance of sonic-pi. We also limited the number of notes that could be played simultaneously, to prevent runtime errors.
We also wanted to give continuity to sounds with the same frequency appearing consecutively in the data, as this is esthetically more pleasing. However, this reduces accuracy from the representation of the physical phenomenon, as the amplitudes of the playing notes, in this version of the script, cannot be modified once they start playing.
From an aesthetic point of view, we chose to play the music with the "hollow" synth, a pre-defined sonic-pi synth. This adds some imperfection to the sound, but we liked its texture, more muffled and filling than the dry "beep" sound.

## Authors Contributions

Matilde Aliffi - ruby & sonic-pi coding.
Auro Michele Perego - physics and numerical simulations.

The project was conceived by Matilde and Auro as an experimental merging of their professional expertise.
Auro contributed to numerical simulations of the NLSE and data mapping
Matilde led the project, contributed to data mapping by writing the Ruby code, filtering scheme, and sound continuity algorithm.

## Contents

- [frequences](frequences.csv) file
- [data](amplitudes.csv) about the amplitude of each frequence in each snapshot
- The [script](unstable_sound.ruby) that generates music
