# Diane
[![Gem Version](https://badge.fury.io/rb/diane.svg)](https://badge.fury.io/rb/diane) ![license](https://img.shields.io/github/license/mnyrop/diane.svg) ![GitHub top language](https://img.shields.io/github/languages/top/mnyrop/diane.svg) [![Inline docs](http://inch-ci.org/github/mnyrop/diane.svg?branch=master)](http://inch-ci.org/github/mnyrop/diane)


[![Build Status](https://travis-ci.org/mnyrop/diane.svg?branch=master)](https://travis-ci.org/mnyrop/diane) [![Maintainability](https://api.codeclimate.com/v1/badges/0e84a1657af9d2258136/maintainability)](https://codeclimate.com/github/mnyrop/diane/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/0e84a1657af9d2258136/test_coverage)](https://codeclimate.com/github/mnyrop/diane/test_coverage) ![Libraries.io](https://img.shields.io/librariesio/github/mnyrop/diane.svg)




### A Ruby CL documentation utility for recording and playing back your thoughts/intel/motivations, without bloating the Git logs. ☕️

<br>

> *I have been assigned a secretary. Her name is Diane.*<br>
> *She seems an interesting cross between a saint and a cabaret singer.*

<br>

<img src="https://media.giphy.com/media/WubJTtnWXKfmM/giphy.gif" width="400"/>

<br>

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'diane'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install diane

<br>

## Usage
<br>

![diane screen gif](./diane.gif)

<br>

Diane has two subcommands: [`record`](#record) and [`playback`](#playback):


### Record


#### Usage:
```sh
diane record MESSAGE
```

#### Example:
```sh
diane record "I'm in the middle of adding git-lfs. Remind me to return + test."
```

#### Options:

- `--user USER` : By default, Diane records the message and attributes it to the git user currently logged in. To override this, use the `--user` option:

    ```sh
    diane record "the owls are not what they seem" --user "the_giant"
    ```

### Playback

#### Usage:
```sh
diane playback NUMBER
```

#### Example:
```sh
diane playback 3
```

#### Options:

- `--all` : By default, Diane plays back 1 recording or the `NUMBER` specified. To override this, use the `--all` option to return every recording that matches the query.

    ```sh
    diane playback --all
    ```

- `--user USER` : By default, Diane plays back the recording(s) attributed to the git user currently logged in. To override this, use the `--user` option:

    ```sh
    diane playback 3 --user "bob"
    ```
- `--everyone` : If you want to return a `NUMBER` of recordings irrespective of user, use the `--everyone` option.

    ```sh
    diane playback --all --everyone
    ```
- `--inorder` : By default, diane plays back the most recent recordings first. You can override this and reverse them with the option `--inorder`.

    ```sh
    diane playback 5 --inorder
    ```
<br>

> __Note:__ By default, `diane playback` with no number or options returns the single most recent result by the logged in user.

<br>

For more, see Diane's [Yardoc](https://www.rubydoc.info/github/mnyrop/diane/master/Diane).

<hr>

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
