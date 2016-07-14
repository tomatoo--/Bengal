#!/bin/bash

gulp build --$1 && gulp build -s --$1
