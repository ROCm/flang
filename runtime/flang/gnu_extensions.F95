! 
! Copyright (c) 2017, NVIDIA CORPORATION.  All rights reserved.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.
! 

!===----------------------------------------------------------------------===!
!====  Copyright (c) 2015 Advanced Micro Devices, Inc.  All rights reserved.
!
!               Developed by: Advanced Micro Devices, Inc.
!
! Permission is hereby granted, free of charge, to any person obtaining a copy
! of this software and associated documentation files (the "Software"), to deal
! with the Software without restriction, including without limitation the
! rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
! sell copies of the Software, and to permit persons to whom the Software is
! furnished to do so, subject to the following conditions:
!
! Redistributions of source code must retain the above copyright notice, this
! list of conditions and the following disclaimers.
!
! Redistributions in binary form must reproduce the above copyright notice,
! this list of conditions and the following disclaimers in the documentation
! and/or other materials provided with the distribution.
!
! Neither the names of Advanced Micro Devices, Inc., nor the names of its
! contributors may be used to endorse or promote products derived from this
! Software without specific prior written permission.
!
! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
! CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
! OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH
! THE SOFTWARE.
!===----------------------------------------------------------------------===!
module GNU_EXTENSIONS
 use ieee_arithmetic, only: ieee_is_nanr4,ieee_is_nanr8
 interface isnan
     module procedure isnanr4, isnanr8
 end interface
 contains
   elemental logical function isnanr4(val)
      real*4,intent(IN) :: val
      isnanr4 = ieee_is_nanr4(val)
   end function
   elemental logical function isnanr8(val)
      real*8,intent(IN) :: val
      isnanr8 = ieee_is_nanr8(val)
   end function
end module GNU_EXTENSIONS
